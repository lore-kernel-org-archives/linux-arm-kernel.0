From: andy.gross@linaro.org (Andy Gross)
Date: Fri, 11 Dec 2015 13:25:55 -0600
Subject: [PATCH 2/4] arm: dts: apq8064: add shared memory into dt
 reserved-memory
In-Reply-To: <1449858707-13517-1-git-send-email-srinivas.kandagatla@linaro.org>
References: <1449858409-13296-1-git-send-email-srinivas.kandagatla@linaro.org>
 <1449858707-13517-1-git-send-email-srinivas.kandagatla@linaro.org>
Message-ID: <20151211192555.GD4022@Agamemnon.attlocal.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 11, 2015 at 06:31:47PM +0000, Srinivas Kandagatla wrote:
> This patch adds the shared memory in the Device tree reserved memory
> list so that kernel would not map it as normal memory.
> 
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

Looks fine to me.
