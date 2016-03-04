From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Fri, 04 Mar 2016 16:05:49 +0900
Subject: [PATCH v2] media: platform: Add missing MFD_SYSCON dependency on
 HAS_IOMEM
In-Reply-To: <87y49yd8t6.fsf@gmail.com>
References: <1457053344-28992-1-git-send-email-k.kozlowski@samsung.com>
 <87y49yd8t6.fsf@gmail.com>
Message-ID: <56D933CD.4070704@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04.03.2016 16:03, Holger Schurig wrote:
> Krzysztof Kozlowski <k.kozlowski@samsung.com> writes:
> 
>> +	depends on HAS_IOMEM	# For MFD_SYSCON
>                             ^^^^^^^^^^^^^^^^
> 
> I think this comment is not necessary, it's also highly unusual. On
> other words: other patches like this don't add such comments.
> 
> You can always use "git blame" to find out why some line has changed the
> way it changed ...

No problem, I can remove it. I thought it might be useful since this
dependency is not for the driver but for selected item.

Best regards,
Krzysztof
