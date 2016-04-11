From: wens@csie.org (Chen-Yu Tsai)
Date: Mon, 11 Apr 2016 22:39:16 +0800
Subject: [PATCH] clk: sunxi: Use resource_size
In-Reply-To: <1460350383-7661-1-git-send-email-vaishali.thakkar@oracle.com>
References: <1460350383-7661-1-git-send-email-vaishali.thakkar@oracle.com>
Message-ID: <CAGb2v64tjgJ54AYiDVDmCS3vJXbXmMxNBmhs0LxKA5hboAJ_xQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 11, 2016 at 12:53 PM, Vaishali Thakkar
<vaishali.thakkar@oracle.com> wrote:
> Use the function resource_size instaed of explicit computation.
>
> Problem found using Coccinelle.
>
> Signed-off-by: Vaishali Thakkar <vaishali.thakkar@oracle.com>

Acked-by: Chen-Yu Tsai <wens@csie.org>
