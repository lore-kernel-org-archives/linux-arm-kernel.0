From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 19 Feb 2015 09:01:46 +0000
Subject: GIC set affinity confusion on ARM
In-Reply-To: <CAGUYZuQiKKxbysuseW8cntLrx_1=iYRpSOj45+XLT7x7LEYdjw@mail.gmail.com>
References: <CAGUYZuQiKKxbysuseW8cntLrx_1=iYRpSOj45+XLT7x7LEYdjw@mail.gmail.com>
Message-ID: <20150219090146.GZ8656@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 19, 2015 at 01:14:27PM +0530, sanjeev sharma wrote:
> Current code of gic_set_affinity() on mainline Tree send interrupt to
> one CPU only. Is this intentionally left feature to not wake up all
> other CPU in SMP Environment ?

Yes, it is intentional.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
