From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Mon, 1 Oct 2018 11:30:04 +0200
Subject: [PATCH V2 09/27] mmc: mmci: modify dma_setup callback
In-Reply-To: <1537523181-14578-10-git-send-email-ludovic.Barre@st.com>
References: <1537523181-14578-1-git-send-email-ludovic.Barre@st.com>
 <1537523181-14578-10-git-send-email-ludovic.Barre@st.com>
Message-ID: <CAPDyKFq-KUNuftT1F7TXMU-Jceqi9GYTWC4Jb7qn3UdpXHR+9Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 21 September 2018 at 11:46, Ludovic Barre <ludovic.Barre@st.com> wrote:
> From: Ludovic Barre <ludovic.barre@st.com>
>
> This patch creates a generic mmci_dma_setup which calls
> dma_setup callback and manages common next_cookie.
> This patch is needed for sdmmc variant which has a different
> dma settings.
>
> Signed-off-by: Ludovic Barre <ludovic.barre@st.com>
>
> # Conflicts:
> #       drivers/mmc/host/mmci.h
>

Please remove this. Looks like some of the other patches in the series
have this in their changelogs as well, please have a look and fix them
all.

[...]

Kind regards
Uffe
