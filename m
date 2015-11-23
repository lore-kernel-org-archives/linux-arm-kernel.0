From: wens@csie.org (Chen-Yu Tsai)
Date: Mon, 23 Nov 2015 15:18:27 +0800
Subject: [PATCH 2/3] rtc: sunxi: constify the data_year_param structure
In-Reply-To: <1447930210-27008-2-git-send-email-clabbe.montjoie@gmail.com>
References: <1447930210-27008-1-git-send-email-clabbe.montjoie@gmail.com>
 <1447930210-27008-2-git-send-email-clabbe.montjoie@gmail.com>
Message-ID: <CAGb2v65vNYg3zEmy+EesuDpfyLDuaCZ-rPPSjzTg4MaDGFGPnA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 19, 2015 at 6:50 PM, LABBE Corentin
<clabbe.montjoie@gmail.com> wrote:
> The data_year_param struct is never modified, so lets constify it.
> This permit to remove cast since of_device_id is const also.
>
> Signed-off-by: LABBE Corentin <clabbe.montjoie@gmail.com>

Acked-by: Chen-Yu Tsai <wens@csie.org>
