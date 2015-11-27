From: broonie@kernel.org (Mark Brown)
Date: Fri, 27 Nov 2015 12:11:26 +0000
Subject: mx28: bad unlock balance detected
In-Reply-To: <CAOMZO5B+j5s69JeeYPnpwn2e_doCA+ARzBSGAcGoJGEJ3=u3BA@mail.gmail.com>
References: <CAOMZO5B+j5s69JeeYPnpwn2e_doCA+ARzBSGAcGoJGEJ3=u3BA@mail.gmail.com>
Message-ID: <20151127121126.GM1929@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 26, 2015 at 02:18:04PM -0200, Fabio Estevam wrote:
> Hi,
> 
> Running linux-next 20151126 on a mx28evk leads to the following bug:
> 
> sgtl5000 0-000a: sgtl5000 revision 0x11
> sgtl5000 0-000a: Using internal LDO instead of VDDD
> 
> =====================================
> [ BUG: bad unlock balance detected! ]
> 4.4.0-rc2-next-20151126-00001-g44eb6b2 #156 Not tainted

This should be fixed in the next -next, Arnd noticed a problem with his
code.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151127/d94668ce/attachment.sig>
