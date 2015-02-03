From: bjorn@kryo.se (Bjorn Andersson)
Date: Tue, 3 Feb 2015 12:38:48 -0800
Subject: [PATCH 0/3] Add initial DT support for Qualcomm SPMI PMIC devices
In-Reply-To: <1422965880-11047-1-git-send-email-iivanov@mm-sol.com>
References: <1422965880-11047-1-git-send-email-iivanov@mm-sol.com>
Message-ID: <CAJAp7OjL6+QLs45LM8pEsZ4tHQ2jgM9z2tg8pb6A=xAxBO7pGA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 3, 2015 at 4:17 AM, Ivan T. Ivanov <iivanov@mm-sol.com> wrote:
> Following set of patches add initial DT support for PMIC devices
> found on recent Quqalcomm chipsets. Details for SPMI bus and PMIC arbiter
> could be found here [1].
>
> Regards,
> Ivan
>
> [1] http://lwn.net/Articles/564637/
>
> Ivan T. Ivanov (3):
>   ARM: dts: qcom: Add SPMI PMIC Arbiter nodes for APQ8084 and MSM8974
>   ARM: dts: qcom: Add 8x74 chipset SPMI PMIC's nodes
>   ARM: dts: qcom: Add APQ8084 chipset SPMI PMIC's nodes
>

Looks good.

Reviewed-by: Bjorn Andersson <bjorn.andersson@sonymobile.com>

Regards,
Bjorn
