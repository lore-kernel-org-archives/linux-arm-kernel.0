From: grant.likely@linaro.org (Grant Likely)
Date: Mon, 24 Mar 2014 05:13:41 -0700
Subject: [RFC] ARM VM System Sepcification
In-Reply-To: <1395651814.4052.6.camel@dagon.hellion.org.uk>
References: <20140226183454.GA14639@cbox>
 <20140306085213.GU643@mal.justgohome.co.uk>
 <53185FB9.1040308@redhat.com> <20140307122418.2F2C4C408EC@trevor.secretlab.ca>
 <20140322122354.7644FC418C4@trevor.secretlab.ca>
 <1395651814.4052.6.camel@dagon.hellion.org.uk>
Message-ID: <CACxGe6vJEXECeUsvMsAMD3soPiPs68aR-izRyou1XmpQCVrGDA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 24, 2014 at 2:03 AM, Ian Campbell <Ian.Campbell@citrix.com> wrote:
> On Sat, 2014-03-22 at 12:23 +0000, Grant Likely wrote:
>> That isn't actually my position. I absolutely think that VMs /should/
>> implement persistent variables, but the variables are a property of a VM
>> instance, not of the disk image. As far as this spec is concerned, I
>> think portable disk images should operate under the assumption of an
>> empty set of variables, and therefore follow the removable disk
>> requirements in the UEFI spec.
>
> Just to be sure I understand. You position is:
>      1. A VM image downloaded from www.distro.org should neither contain
>         nor expect any persistent variables to be present.

yes

>      2. After a VM image is instantiated into a specific VM instance and
>         booted then it is at liberty to set persistent variables (either
>         on first boot or as part of an upgrade) and the VM should ensure
>         that those variables a retained over reboot for that specific
>         instance.

yes

>      3. If a VM does not preserve those variables then the instance
>         should have some sane functional fallback (implied by the
>         removable disk requirements from the UEFI spec).

yes

> Is that right? I'm pretty sure you meant (1), reasonably sure you meant
> (2) and not at all sure you meant (3) ;-)
>
> Ian.
>
