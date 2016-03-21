From: andy.gross@linaro.org (Andy Gross)
Date: Sun, 20 Mar 2016 22:50:43 -0500
Subject: [RFC v3 11/12] ARM64: dts: Add PSCI cpuidle support for MSM8916
In-Reply-To: <1456866931-37851-13-git-send-email-lina.iyer@linaro.org>
References: <1456866931-37851-1-git-send-email-lina.iyer@linaro.org>
 <1456866931-37851-13-git-send-email-lina.iyer@linaro.org>
Message-ID: <20160321034639.GA3106@hector.attlocal.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 01, 2016 at 02:15:30PM -0700, Lina Iyer wrote:
> Add device bindings for CPUs to suspend using PSCI as the enable-method.
> 
> Cc: <devicetree@vger.kernel.org>
> Signed-off-by: Lina Iyer <lina.iyer@linaro.org>

Works great.  All CPUs functional and I saw SPC idle states incrementing.

Tested-by: Andy Gross <andy.gross@linaro.org>
