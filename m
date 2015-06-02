From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 2 Jun 2015 10:43:06 +0100
Subject: [PATCH v9 4/6] Documentation: DT: PL011: hi6220: add compatible
 string for Hisilicon designed UART
In-Reply-To: <556D73B6.4090608@arm.com>
References: <1432950661-23060-1-git-send-email-bintian.wang@huawei.com>
 <1432950661-23060-5-git-send-email-bintian.wang@huawei.com>
 <CACRpkdav_5x6RC9F++ErvqGyxDCF-=kap7-jCsO4zZ6QGVLfBQ@mail.gmail.com>
 <556D73B6.4090608@arm.com>
Message-ID: <20150602094305.GA2067@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 02, 2015 at 10:13:26AM +0100, Marc Zyngier wrote:
> That feels weird. This amba_vendor enum is not under control of the DT
> author, nor the kernel. This is a set of codes that are managed by a
> third party (probably ARM). What if some company with a name starting
> with 'H' (Hilarious Inc?) comes up with some actual HW and ends up
> conflicting with the above?

Presumably, HiSilicon have their own vendor code already, which
presumably would be required for them to have a license to modify
ARM IP.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
