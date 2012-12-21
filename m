From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 21 Dec 2012 09:24:21 +0000
Subject: [PATCH 4/4] net/smsc911x: Provide common clock functionality
In-Reply-To: <20121221091306.GO2691@gmail.com>
References: <1355937587-31730-1-git-send-email-lee.jones@linaro.org>
 <1355937587-31730-4-git-send-email-lee.jones@linaro.org>
 <CACRpkda79O_b3Z8g7Sy7vMtW9neZU4x-Z=iEQgjqu4X5tFKyhw@mail.gmail.com>
 <20121220192441.GC14363@n2100.arm.linux.org.uk>
 <20121220203514.GN2691@gmail.com>
 <20121220205113.GD14363@n2100.arm.linux.org.uk>
 <20121221091306.GO2691@gmail.com>
Message-ID: <20121221092421.GG14363@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 21, 2012 at 09:13:06AM +0000, Lee Jones wrote:
> Are you saying remove "pdata->clk = NULL;" and test for IS_ERR
> every time?

Exactly.
