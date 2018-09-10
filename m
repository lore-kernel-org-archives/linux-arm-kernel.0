From: srinivas.kandagatla@linaro.org (Srinivas Kandagatla)
Date: Mon, 10 Sep 2018 09:55:01 +0100
Subject: [PATCH v2 13/16] nvmem: add support for cell lookups from machine
 code
In-Reply-To: <20180910102324.52ecd8f7@bbrezillon>
References: <20180907100750.14564-1-brgl@bgdev.pl>
 <20180907100750.14564-14-brgl@bgdev.pl>
 <484b6ec5-cd8e-e5c5-0c5c-2f11c504ea1c@linaro.org>
 <CAMRc=MdnSHY1ah4X3Bu55HvZcOQHxPHaFudidDA4mEOW9ZzeEg@mail.gmail.com>
 <20180910102324.52ecd8f7@bbrezillon>
Message-ID: <c72866dd-1fb0-c765-5815-ba63d051a09b@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 10/09/18 09:23, Boris Brezillon wrote:
> Well, if we get rid of nvmem-machine.h, the cell-lookup stuff
> should go in nvmem-consumer.h not nvmem-provider.h. On the other hand,
> everything that is related to cell creation should be placed in
> nvmem-provider.h.
Yes, this is how it should be!

--srini
