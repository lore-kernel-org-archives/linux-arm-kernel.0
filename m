From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sun, 20 Jul 2014 10:59:46 +0100
Subject: Edma.c: Fix Mes
In-Reply-To: <CAPDOMVhd-mfNfT+DbHWbzQA8sb3xpqW6a0WEuTTeCGyK8+kRNQ@mail.gmail.com>
References: <CAPDOMVhd-mfNfT+DbHWbzQA8sb3xpqW6a0WEuTTeCGyK8+kRNQ@mail.gmail.com>
Message-ID: <20140720095945.GE21766@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jul 20, 2014 at 12:27:37AM -0400, Nick Krause wrote:
> Hey Russell and others,
> Sorry to bug you again but I have a fix questions before I clean up
> the fix mes in this file.
> Is edma_clean_channel needed or is edma_stop good enough?  And do  we
> CCERR.BIT(16)
> need to write this bit or not?

I have no idea.  That's why I'm not trying to fix it; it's best left
alone unless you know for certain how to fix it _and_ that you can
fix it _correctly_.

-- 
FTTC broadband for 0.8mile line: currently at 9.5Mbps down 400kbps up
according to speedtest.net.
