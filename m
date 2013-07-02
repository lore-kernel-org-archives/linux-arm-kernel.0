From: richard.genoud@gmail.com (Richard Genoud)
Date: Tue, 2 Jul 2013 10:13:08 +0200
Subject: [RFC PATCH 01/13] misc: atmel_ssc: add device tree DMA support
In-Reply-To: <51D24299.9050209@atmel.com>
References: <1372667978-4718-1-git-send-email-richard.genoud@gmail.com>
 <1372667978-4718-2-git-send-email-richard.genoud@gmail.com>
 <51D24299.9050209@atmel.com>
Message-ID: <CACQ1gAgcc=j3kmcpjp8bbdHhxr_k=h8jJs6R_paJbPUMv74uGg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2013/7/2 Bo Shen <voice.shen@atmel.com>:
> Hi Richard,
>
>
> On 7/1/2013 16:39, Richard Genoud wrote:
>>
>> The ssc device has to fill the at_dma_slave structure with the
>> device tree informations.
>> Doing a of_dma_request_slave_channel()+dma_release_channel() for that
>> seems wrong (or at least not very clean).
>
>
> Please hold on of this, as to the ASoC dmaengine will deal with this. So, we
> not need do it manually.
>
> Now, I am working on it. And will send out the patch soon after testing OK.
Ok, I stay tuned !

Thanks !

Best regards,
Richard
