From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Sat, 07 Sep 2013 17:36:11 +0400
Subject: [patch 1/1] imx51.dtsi: fix PATA device clock
In-Reply-To: <20130907132507.353801753@rtp-net.org>
References: <20130907132507.353801753@rtp-net.org>
Message-ID: <522B2BCB.1050209@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 07-09-2013 17:23, Arnaud Patard (Rtp) wrote:

    Why you sent the patch as attachment?

> Commit 718a35006f3fa48540d69bd649ff76ea4cdc1ef2 adds pata support to the
> imx51.dtsi file and is using clock 161. The problem is that the right clock
> is 172, according to 5d530bb0ad84d403d1aac79a8a8acf2c2b0a8dd7.

    Please specify those commits' summaries in paren

> Using the clock 172 makes things work again (and kills a nasty system freeze)


> Tested-by: Steve Klimaszewski<steev@gentoo.org>
> Signed-off-by: Arnaud Patard<arnaud.patard@rtp-net.org>

WBR, Sergei
