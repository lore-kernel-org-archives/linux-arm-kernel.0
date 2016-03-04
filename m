From: holgerschurig@gmail.com (Holger Schurig)
Date: Fri, 04 Mar 2016 08:03:01 +0100
Subject: [PATCH v2] media: platform: Add missing MFD_SYSCON dependency on
 HAS_IOMEM
In-Reply-To: <1457053344-28992-1-git-send-email-k.kozlowski@samsung.com>
 (Krzysztof Kozlowski's message of "Fri, 04 Mar 2016 10:02:24 +0900")
References: <1457053344-28992-1-git-send-email-k.kozlowski@samsung.com>
Message-ID: <87y49yd8t6.fsf@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Krzysztof Kozlowski <k.kozlowski@samsung.com> writes:

> +	depends on HAS_IOMEM	# For MFD_SYSCON
                            ^^^^^^^^^^^^^^^^

I think this comment is not necessary, it's also highly unusual. On
other words: other patches like this don't add such comments.

You can always use "git blame" to find out why some line has changed the
way it changed ...
