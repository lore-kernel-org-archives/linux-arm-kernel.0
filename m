From: marc@cpdesign.com.au (Marc Reilly)
Date: Tue, 22 Feb 2011 14:23:45 +1100
Subject: mc13xxx-core, support for i2c, V4
In-Reply-To: <20110221163347.GG10686@sortiz-mobl>
References: <1294119299-18352-1-git-send-email-marc@cpdesign.com.au>
	<201102122111.30525.marc@cpdesign.com.au>
	<20110221163347.GG10686@sortiz-mobl>
Message-ID: <201102221423.45932.marc@cpdesign.com.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Samuel,


> > > {Grant wrote}
> > > This series looks okay to me.  Since this is audio drivers, I expect
> > > that it would best be taken via the ASoC tree?  Have you sent it to
> > > Mark Brown and the ALSA list for review?
> > > 
> > > g.
> > 
> > Actually only the mc13873 has audio support. I think these IC's really
> > fit better under the MFD tree, but silly me didn't add Samuel Ortiz (MFD
> > maintainer) to this series... so included him now.
> > 
> > Samuel, are you the most appropriate to take this series in and would you
> > like me to resend these patches to you? The thread archive is at [1].
> 
> Yes, I would be the one taking those patches. Please resend the patch set
> to me, and I'll have a look. 

I don't have the original patch files available to resend the normal way, but 
attached are the 4 patch files off of patchwork [1]. Apologies if they are not 
what is required/inconvenient for you.

> Has Uwe commented on them yet ?
Uwe was very helpful in the first three versions of this series, but didn't 
have anything to say about V4.


Cheers
Marc

[1] https://patchwork.kernel.org/patch/449541/

-------------- next part --------------
A non-text attachment was scrubbed...
Name: v4-1-4-mc13xxx-core-Prepare-for-separate-spi-and-i2c-backends..patch
Type: text/x-patch
Size: 11185 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20110222/eec38aa9/attachment-0004.bin>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: v4-2-4-mc13xxx-core-Kconfig-Config-menu-driven-by-specific-IC-type.patch
Type: text/x-patch
Size: 2740 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20110222/eec38aa9/attachment-0005.bin>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: v4-3-4-mc13xxx-core-Move-spi-specific-code-into-separate-module..patch
Type: text/x-patch
Size: 10876 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20110222/eec38aa9/attachment-0006.bin>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: v4-4-4-mc13xxx-core-Add-i2c-driver.patch
Type: text/x-patch
Size: 5118 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20110222/eec38aa9/attachment-0007.bin>
