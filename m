From: festevam@gmail.com (Fabio Estevam)
Date: Mon, 26 Nov 2018 12:31:40 -0200
Subject: [PATCH] arm64: dts: qcom: qcs404: Add WCN3990 WLAN module device
 node
In-Reply-To: <20181126142133.16966-1-govinds@codeaurora.org>
References: <20181126142133.16966-1-govinds@codeaurora.org>
Message-ID: <CAOMZO5Dne5utQ6i+n_Ab1=9AG7WYcZRhq7GY72rqyEdyau0swA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 26, 2018 at 12:22 PM Govind Singh <govinds@codeaurora.org> wrote:

> +
> +               wifi: wifi at 0A000000 {

Please remove the leading zero. Building with W=1 would warn you about that.
