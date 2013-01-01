From: sylvester.nawrocki@gmail.com (Sylwester Nawrocki)
Date: Tue, 01 Jan 2013 19:33:42 +0100
Subject: [PATCH RESEND 6/6] clk: s5p-g2d: Fix incorrect usage of
 IS_ERR_OR_NULL
In-Reply-To: <50D62BC9.9010706@mvista.com>
References: <1355852048-23188-1-git-send-email-linux@prisktech.co.nz>
 <1355852048-23188-7-git-send-email-linux@prisktech.co.nz>
 <50D62BC9.9010706@mvista.com>
Message-ID: <50E32C06.5020104@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/22/2012 10:53 PM, Sergei Shtylyov wrote:
> Hello.
>
> On 18-12-2012 21:34, Tony Prisk wrote:
>
>> Resend to include mailing lists.
>
> Such remarks should be placed under --- tear line, not in the changelog.
>
>> Replace IS_ERR_OR_NULL with IS_ERR on clk_get results.
>
>> Signed-off-by: Tony Prisk <linux@prisktech.co.nz>
>> CC: Kyungmin Park <kyungmin.park@samsung.com>
>> CC: Tomasz Stanislawski <t.stanislaws@samsung.com>
>> CC: linux-media at vger.kernel.org

I've applied first version of this patch to my tree for 3.9, thanks.
