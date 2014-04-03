From: robherring2@gmail.com (Rob Herring)
Date: Thu, 3 Apr 2014 14:56:02 -0500
Subject: [PATCH V2 11/19] mmc: mmci: Mark the DT bindings for highspeed
 mode as deprecated
In-Reply-To: <1396279100-2920-12-git-send-email-ulf.hansson@linaro.org>
References: <1396279100-2920-1-git-send-email-ulf.hansson@linaro.org>
 <1396279100-2920-12-git-send-email-ulf.hansson@linaro.org>
Message-ID: <CAL_Jsq+ncfdPeD53p60MNM1z8fP0Tpec39UGEDQR=7-hnvQ_iQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 31, 2014 at 10:18 AM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> The common mmc DT parser supports bindings for highspeed mode, thus
> there are no need for mmci to provide it's own versions for these. Mark
> them as deprecated in the documentation.
>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>

Acked-by: Rob Herring <robh@kernel.org>
