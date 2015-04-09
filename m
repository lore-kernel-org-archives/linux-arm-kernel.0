From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Thu, 9 Apr 2015 09:27:47 +0200
Subject: [PATCH 1/6] clk: make strings in parent name arrays const
In-Reply-To: <1427825817-26773-2-git-send-email-s.hauer@pengutronix.de>
References: <1427825817-26773-1-git-send-email-s.hauer@pengutronix.de>
 <1427825817-26773-2-git-send-email-s.hauer@pengutronix.de>
Message-ID: <CAJKOXPeNw6teVhgnuW3da=chMemCErTWK_oV4rx=CBaHjyTQ7w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2015-03-31 20:16 GMT+02:00 Sascha Hauer <s.hauer@pengutronix.de>:
> The clk functions and structs declare the parent_name arrays as
> 'const char **parent_names' which means the parent name strings
> are const, but the array itself is not. Use
> 'const char * const * parent_names' instead which also makes
> the array const. This allows us to put the parent_name arrays into
> the __initconst section.
>
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>

Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>

and tested:
Tested-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>


Best regards,
Krzysztof
