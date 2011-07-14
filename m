From: vapier.adi@gmail.com (Mike Frysinger)
Date: Thu, 14 Jul 2011 13:10:09 -0400
Subject: [PATCH v2] mtd: dataflash: add device tree probe support
In-Reply-To: <1310658757-17018-1-git-send-email-shawn.guo@linaro.org>
References: <1310283313-32087-1-git-send-email-shawn.guo@linaro.org>
	<1310658757-17018-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <CAMjpGUeU04ziDWyxjgY52xHYxqQZGjzsn6JcJa3X0FR33AGDSw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

shouldnt there be #ifdef's around this ?  not everyone supports devicetrees.
-mike
