From: skannan@codeaurora.org (Saravana Kannan)
Date: Tue, 01 Mar 2011 18:59:19 -0800
Subject: [PATCH] msm: gpiomux: Remove GPIOMUX_VALID and merge config enums
In-Reply-To: <AANLkTi=ePu9hTeecOfKoxKEXd6VZ6tJBN2XphDO5suOA@mail.gmail.com>
References: <4D680EEE.1070706@codeaurora.org>	<AANLkTinZCtbQnAk_OX92jqbW_GjH5wpxvbeoMkHV1inn@mail.gmail.com>	<4D689230.7020704@codeaurora.org>
	<AANLkTi=ePu9hTeecOfKoxKEXd6VZ6tJBN2XphDO5suOA@mail.gmail.com>
Message-ID: <4D6DB287.4000102@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/01/2011 06:25 PM, Dima Zavin wrote:
> Good point, ptr to anon struct would work.

Glad to know the suggestion helped.

> I would still very much like to see the helper macros be added though
> as it really would be very helpful in keeping the pinmuxing tidy in
> the board files. Doing it as a separate patch is fine.
>
> Other than the addition of helper macros, ack.

Rohit, would you mind adding the helper macros that use pointer to anon 
struct to simplify the GPIO config population in the board files? You 
can contact me offline if you need any help with it.

Thanks,
Saravana
-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
