From: swarren@wwwdotorg.org (Stephen Warren)
Date: Fri, 02 Aug 2013 15:52:52 -0600
Subject: [RFC PATCH V2 4/9] s/.name/.compatible/
In-Reply-To: <1e66851fa0a7c137afbb39a27c77d5a585b466f6.1375457714.git.jason@lakedaemon.net>
References: <cover.1375457714.git.jason@lakedaemon.net>
 <1e66851fa0a7c137afbb39a27c77d5a585b466f6.1375457714.git.jason@lakedaemon.net>
Message-ID: <51FC2A34.8010806@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/02/2013 09:51 AM, Jason Cooper wrote:
> Signed-off-by: Jason Cooper <jason@lakedaemon.net>

> diff --git a/board-raumfeld.c b/board-raumfeld.c

> @@ -21,19 +21,19 @@ static struct board boards[] = {
>  		.machid		= 2413,
>  		.system_rev	= 0,
>  		.dtb		= &_binary_input_raumfeld_controller_0_dtb_start,
> -		.name		= "Raumfeld Controller, revision 0",
> +		.compatible	= "Raumfeld Controller, revision 0",

This looks a little unfortunate; those values don't look like they're
the contents of the DT compatible property.
