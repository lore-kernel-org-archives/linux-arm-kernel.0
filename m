From: ijc@hellion.org.uk (Ian Campbell)
Date: Thu, 24 Nov 2016 17:03:46 +0000
Subject: [linux-sunxi] Re: [RFC PATCH 0/5] arm64: Allwinner H5 support
In-Reply-To: <560f873c-7ad9-5614-21f6-489879380ebe@arm.com>
References: <1479950235-26821-1-git-send-email-andre.przywara@arm.com>
 <20161124105958.xzp4fr2fs4p42upx@lukather>
 <560f873c-7ad9-5614-21f6-489879380ebe@arm.com>
Message-ID: <1480007026.4509.69.camel@hellion.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2016-11-24 at 11:05 +0000, Andre Przywara wrote:
> 
> > I don't have any major comments but I guess it all depends on the DT
> > maintainers view on the symbolic link to share the DTSI.
> 
> I am curious too ;-)
> But I saw symlinks for the RaspberryPi 3 (check
> arch/arm64/boot/dts/broadcom) and VExpress, so I picked that low hanging
> fruit ;-)

See http://git.kernel.org/torvalds/linux/c/8ee57b8182c4?and the ML
discussion around the posting of that for some background on why the
symlinks are being used in preference to #include or /include/.

IIRC there was some further discussion on some lists when?http://git.ke
rnel.org/torvalds/linux/c/76aa75916880?was posted too.

Ian.
