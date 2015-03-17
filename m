From: maxime.coquelin@st.com (Maxime Coquelin)
Date: Tue, 17 Mar 2015 09:33:17 +0100
Subject: [PATCH 27/35 linux-next] reset: sti: constify of_device_id array
In-Reply-To: <1426535685-25996-6-git-send-email-fabf@skynet.be>
References: <1426533469-25458-1-git-send-email-fabf@skynet.be>
 <1426535685-25996-1-git-send-email-fabf@skynet.be>
 <1426535685-25996-6-git-send-email-fabf@skynet.be>
Message-ID: <5507E6CD.6050603@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 03/16/2015 08:54 PM, Fabian Frederick wrote:
> of_device_id is always used as const.
> (See driver.of_match_table and open firmware functions)
>
> Signed-off-by: Fabian Frederick <fabf@skynet.be>
> ---
>   drivers/reset/sti/reset-stih407.c | 2 +-
>   drivers/reset/sti/reset-stih415.c | 2 +-
>   drivers/reset/sti/reset-stih416.c | 2 +-
>   3 files changed, 3 insertions(+), 3 deletions(-)
>
>

Acked-by: Maxime Coquelin <maxime.coquelin@st.com>

Thanks!
Maxime
