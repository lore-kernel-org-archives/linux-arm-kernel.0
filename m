From: dan.carpenter@oracle.com (Dan Carpenter)
Date: Tue, 20 Aug 2013 11:13:48 +0300
Subject: [PATCH v3 1/2] dmaengine: add interface of dma_get_slave_channel
In-Reply-To: <CAMj5Bkhq=kvfpYiMX0de3PBaAzOUfgPVELamaeMAWhHaoDgc8g@mail.gmail.com>
References: <1376550163-30145-1-git-send-email-zhangfei.gao@linaro.org>
 <1376550163-30145-2-git-send-email-zhangfei.gao@linaro.org>
 <20130819052516.GT32147@intel.com>
 <CAMj5Bkhq=kvfpYiMX0de3PBaAzOUfgPVELamaeMAWhHaoDgc8g@mail.gmail.com>
Message-ID: <20130820081348.GV4713@mwanda>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 20, 2013 at 03:58:41PM +0800, zhangfei gao wrote:

> BTW, it is strange I do not see such compile warning here :(

This was a Smatch static checker warning, not a regular build
warning.

regards,
dan carpenter
