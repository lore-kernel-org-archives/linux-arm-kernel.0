From: andy.gross@linaro.org (Andy Gross)
Date: Thu, 31 Mar 2016 13:20:32 -0500
Subject: [PATCH v2 3/3] ARM: dts: apq8064: add ahci ports-implemented mask
In-Reply-To: <1459445500-9071-4-git-send-email-srinivas.kandagatla@linaro.org>
References: <1459445500-9071-1-git-send-email-srinivas.kandagatla@linaro.org>
 <1459445500-9071-4-git-send-email-srinivas.kandagatla@linaro.org>
Message-ID: <20160331181533.GA8252@hector.attlocal.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 31, 2016 at 06:31:40PM +0100, Srinivas Kandagatla wrote:
> This patch adds new ports-implemented mask, which is required to get
> achi working on the mainline. Without this patch value read from
> PORTS_IMPL register which is zero would not enable any ports for
> software to use.
> 
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

Acked-by: Andy Gross <andy.gross@linaro.org>
