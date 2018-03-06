From: bich.hemon@st.com (Bich HEMON)
Date: Tue, 6 Mar 2018 09:58:38 +0000
Subject: [PATCH 0/2] Update interrupt names
In-Reply-To: <1519815044-22669-1-git-send-email-bich.hemon@st.com>
References: <1519815044-22669-1-git-send-email-bich.hemon@st.com>
Message-ID: <d855b529-be9b-13d9-8834-c2d0b7a16884@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

On 02/28/2018 11:51 AM, Bich HEMON wrote:
> This patchset updates existing stm32 usart driver by updating interrupt
> initialization by name.
> 
> Bich Hemon (2):
>    dt-bindings: serial: stm32: add wakeup option using note
>    serial: stm32: update interrupt initialization
> 
>   Documentation/devicetree/bindings/serial/st,stm32-usart.txt | 4 ++++
>   drivers/tty/serial/stm32-usart.c                            | 4 ++--
>   2 files changed, 6 insertions(+), 2 deletions(-)
> 

Please note that this patch set is abandoned. As Rob pointed that out, 
the interrupt indices are fixed, so there is no need to keep these patches.

Best regards,

Bich
