From: jonsmirl@gmail.com (jonsmirl at gmail.com)
Date: Wed, 31 Jul 2013 08:01:54 -0400
Subject: Defining schemas for Device Tree
In-Reply-To: <20130731113401.GM9858@sirena.org.uk>
References: <1706112.Xn49tiCSKF@thinkpad>
 <CAKON4OwNrhmvnznyeD-igtZ5nsm7atUZoa0RJttN5kmwKubaDg@mail.gmail.com>
 <20130730102511.GM9858@sirena.org.uk>
 <CAKON4OxSr13VPJkwkvuF91BwFXfQ6fkAuVeEsiA=JK3cuzmavQ@mail.gmail.com>
 <51F7F596.6020503@wwwdotorg.org>
 <CAKON4OykPqYA8+ZGxjiX00Ut+iM9hqiXr5D9KEZF3PVxoqiM1g@mail.gmail.com>
 <20130730205716.GZ9858@sirena.org.uk>
 <CAKON4Ox7-6Jf0ce64Wqr5E49KS+9E135mqc_iG-PWQ7r8bzWHA@mail.gmail.com>
 <20130730230331.GC9858@sirena.org.uk>
 <CAKON4OzFdZhX0Kzu_6KiimD=KxDr6EM13zUH3GGE=hHaYx=m=Q@mail.gmail.com>
 <20130731113401.GM9858@sirena.org.uk>
Message-ID: <CAKON4OyQUcqw1RFcWj3uy0i2i+3UBB8fG1rPw6tcrMGDZ40y6g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 31, 2013 at 7:34 AM, Mark Brown <broonie@kernel.org> wrote:
> On Tue, Jul 30, 2013 at 07:23:36PM -0400, jonsmirl at gmail.com wrote:
>
>> Uboot could be an issue but I don't think they are actually doing
>> anything with FDTs yet, they are just talking about doing it.
>
> Right, plus any other bootloaders that handle the DT in some way.  Those
> that just copy the file through without looking at it aren't an issue
> but I thought people were doing things like adding in properties for
> serial numbers but perhaps that's less widespread than I'd thought and
> it's not an issue.

uboot patches up the amount of RAM it finds into the FDT. It might
patch up clock speed too, I don't remember. I haven't seen it add
serial numbers but it might, not sure which serial numbers.

There has been talk for several years about turning uboot into a bunch
of device drivers and using FDT to control it. Allwinner has done that
with the fex implementation. The uboot work is still in the talking
about it phase.

-- 
Jon Smirl
jonsmirl at gmail.com
