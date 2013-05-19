From: arnd@arndb.de (Arnd Bergmann)
Date: Sun, 19 May 2013 21:48:46 +0200
Subject: [RFC PATCHv3 3/6] clk: Add TI-Nspire clock drivers
In-Reply-To: <F8915E01-0FCA-4C9F-8440-63B5A73B349B@gmail.com>
References: <1368332581-94691-1-git-send-email-dt.tangr@gmail.com>
 <201305161417.28133.arnd@arndb.de>
 <F8915E01-0FCA-4C9F-8440-63B5A73B349B@gmail.com>
Message-ID: <201305192148.46398.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sunday 19 May 2013, Daniel Tang wrote:
> If the vendors for the on-SOC components are unknown, should we just
> leave the compatible strings as is (i.e. "nspire-XXX")?

In that case, I would use the name of the company that made the SoC.
I believe someone mentioned it was made by LSI logic.

	Arnd
