From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 8 Jun 2017 14:38:44 +0200
Subject: Staging r8723bs driver for kernel 4.12.0-rc2 on CHIPPro
In-Reply-To: <1496925243.11482.19.camel@hadess.net>
References: <bcc1a7c44ba34cb077a1df09971d6926@www.akkea.ca>
 <8485e88721d4761d5b1a10ff1eebfd36@www.akkea.ca>
 <1496925243.11482.19.camel@hadess.net>
Message-ID: <20170608123844.igx7dofpakpcqg4o@flea.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Bastien,

On Thu, Jun 08, 2017 at 02:34:03PM +0200, Bastien Nocera wrote:
> On Wed, 2017-05-31 at 10:29 -0600, Angus Ainslie wrote:
> > On 2017-05-24 15:03, Angus Ainslie wrote:
> > > Hi
> > > 
> > > Has the realtek rtl8723bs staging driver in kernel 4.12.0-rc2 been
> > > tested on the CHIPPro.
> > > 
> > 
> > This is still an issue with 4.12.0-rc3
> 
> I only have access to the original CHIP, and the default kernel
> configuration there didn't have the necessary options for the staging
> driver to work.
> 
> I filed a bug and a PR a while ago:
> https://github.com/NextThingCo/CHIP-linux/issues/33
> https://github.com/NextThingCo/CHIP-linux/pull/39
> 
> I haven't looked at it again in a long while due to lack of time, but
> that might be a good first pass at the problem, before getting onto the
> CHIP Pro.

This is for the old NTC's 4.4 kernel though. I think Angus is talking
about a mainline 4.12.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170608/7c62a058/attachment-0001.sig>
