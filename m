From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 24 Feb 2015 10:48:57 +0100
Subject: [PATCH v4 2/8] arm64: dts: exynos: Add dts files for 64-bit
 Exynos5433 SoC
In-Reply-To: <54EC3BB1.1020701@samsung.com>
References: <1424755011-15999-1-git-send-email-cw00.choi@samsung.com>
 <7139111.LGA4lhSjob@wuerfel> <54EC3BB1.1020701@samsung.com>
Message-ID: <7412525.l6YnQcTxtg@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 24 February 2015 17:52:01 Chanwoo Choi wrote:
> 
> But, I have a question.
> If we put the aliases into the board dts file instaed of SoC dtsi,
> each board dts file may use the different alias name about same phandle.

Yes, that is the idea. In particular with the uarts, the intention is
that the numbering of the device nodes in /dev is the same that is
printed on the board (if any), which may be different from the numbering
internal to the SoC.

	Arnd 
