From: broonie@kernel.org (Mark Brown)
Date: Wed, 31 Jul 2013 12:34:01 +0100
Subject: Defining schemas for Device Tree
In-Reply-To: <CAKON4OzFdZhX0Kzu_6KiimD=KxDr6EM13zUH3GGE=hHaYx=m=Q@mail.gmail.com>
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
Message-ID: <20130731113401.GM9858@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 30, 2013 at 07:23:36PM -0400, jonsmirl at gmail.com wrote:

> Uboot could be an issue but I don't think they are actually doing
> anything with FDTs yet, they are just talking about doing it.

Right, plus any other bootloaders that handle the DT in some way.  Those
that just copy the file through without looking at it aren't an issue
but I thought people were doing things like adding in properties for
serial numbers but perhaps that's less widespread than I'd thought and
it's not an issue.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130731/85b18fa2/attachment.sig>
