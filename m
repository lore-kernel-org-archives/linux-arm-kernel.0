From: riel@redhat.com (Rik van Riel)
Date: Tue, 08 Jul 2014 23:11:45 -0400
Subject: [PATCH v3 06/12] sched: add per rq cpu_power_orig
In-Reply-To: <1404144343-18720-7-git-send-email-vincent.guittot@linaro.org>
References: <1404144343-18720-1-git-send-email-vincent.guittot@linaro.org>
 <1404144343-18720-7-git-send-email-vincent.guittot@linaro.org>
Message-ID: <53BCB2F1.3070400@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 06/30/2014 12:05 PM, Vincent Guittot wrote:
> This new field cpu_power_orig reflects the available capacity of a
> CPUs unlike the cpu_power which reflects the current capacity that
> can be altered by frequency and rt tasks.
> 
> Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>

Acked-by: Rik van Riel <riel@redhat.com>


- -- 
All rights reversed
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBAgAGBQJTvLLxAAoJEM553pKExN6DKHsIALFlj278vKIifriFbVOOYgDf
RppA21YTjzYP8YE00h0INatqPeIBRn5u1ifHUzlAtGIIV8dWy5q8QKu3D5zxNPfH
hTxqyX/vMYcLTJOC9yXPS+mM/wcOx1JEpNnuRtF3UZgjG+70boPuGLvlecy+mxz9
mtW6StYOxX0/WgHgbWHMYaVDCKGdn5P2ey6azD2Hrvmp6XsVat8T9+ChdmRJ0/t+
0D7QrEo56h+YSU3l0TqoHFwT/8l8pyGGyYOi1ABeZIaY13W2SJu2Ec4cYhK6qqmN
uz69QWwTPa1gOPTqpj1f8g64/ckBjwKaA7hB9GLCqqk1cuI6PK22B5QJEg/9BpE=
=wa9A
-----END PGP SIGNATURE-----
