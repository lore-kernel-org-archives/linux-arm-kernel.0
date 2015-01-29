From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 29 Jan 2015 23:05:35 +0000
Subject: linux-next: manual merge of the arm-soc tree with the arm tree
In-Reply-To: <20150130095533.315d3831@canb.auug.org.au>
References: <20150130095533.315d3831@canb.auug.org.au>
Message-ID: <20150129230535.GG26493@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 30, 2015 at 09:55:33AM +1100, Stephen Rothwell wrote:
> Hi all,
> 
> Today's linux-next merge of the arm-soc tree got a conflict in
> arch/arm/Kconfig.debug between commit 4d31e6641295 ("ARM: 8272/1: netx:
> Migrate DEBUG_LL macros to shared directory") from the  tree and
> commits 01ea63d99397 ("ARM: sirf: add two debug ports for CSRatlas7
> SoC") and e23814da8262 ("ARM: digicolor: add low level debug support")
> from the arm-soc tree.
> 
> I fixed it up (see below) and can carry the fix as necessary (no action
> is required).

Both of these conflict resolutions (the other one you sent after this)
look reasonable, thanks Stephen.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
