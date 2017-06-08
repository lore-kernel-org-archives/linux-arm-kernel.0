From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 8 Jun 2017 15:23:31 +0200
Subject: Staging r8723bs driver for kernel 4.12.0-rc2 on CHIPPro
In-Reply-To: <32a79e1299eecf52c454cf3e80e903ac@www.akkea.ca>
References: <bcc1a7c44ba34cb077a1df09971d6926@www.akkea.ca>
 <8485e88721d4761d5b1a10ff1eebfd36@www.akkea.ca>
 <1496925243.11482.19.camel@hadess.net>
 <20170608123844.igx7dofpakpcqg4o@flea.home>
 <32a79e1299eecf52c454cf3e80e903ac@www.akkea.ca>
Message-ID: <20170608132331.zmqsjqeffu55rwh4@flea.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 08, 2017 at 07:13:56AM -0600, Angus Ainslie wrote:
> On 2017-06-08 06:38, Maxime Ripard wrote:
> > 
> > This is for the old NTC's 4.4 kernel though. I think Angus is talking
> > about a mainline 4.12.
> > 
> 
> Yeah I'm working with the 4.12 kernel . I would have just stuck with the 4.4
> but I wasn't able to get suspend working on 4.4 . 4.12 suspend looks to be
> working so I started forward on that.

Who told you that? suspend is not implemented, neither in NTC's 4.4
nor mainline 4.12.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170608/79070d33/attachment.sig>
