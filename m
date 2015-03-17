From: patrice.chotard@st.com (Patrice Chotard)
Date: Tue, 17 Mar 2015 09:10:37 +0100
Subject: [PATCH 05/35 linux-next] tty: constify of_device_id array
In-Reply-To: <1426533469-25458-6-git-send-email-fabf@skynet.be>
References: <1426533469-25458-1-git-send-email-fabf@skynet.be>
 <1426533469-25458-6-git-send-email-fabf@skynet.be>
Message-ID: <5507E17D.2050701@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Fabian

On 03/16/2015 08:17 PM, Fabian Frederick wrote:
> of_device_id is always used as const.
> (See driver.of_match_table and open firmware functions)
>
> Signed-off-by: Fabian Frederick <fabf@skynet.be>
> ---
....
>   drivers/tty/serial/st-asc.c                 | 2 +-
>
For this driver

Acked-by: Patrice Chotard <patrice.chotard@st.com>

Thanks
