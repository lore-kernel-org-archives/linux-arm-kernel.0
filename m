From: gcembed@gmail.com (=?UTF-8?B?R2HDq3RhbiBDYXJsaWVy?=)
Date: Tue, 19 Feb 2013 02:47:05 +0100
Subject: coda: support of decoding
Message-ID: <5122D999.3070405@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,
I see in code source of coda driver that decoding is not supported.

ctx->inst_type = CODA_INST_DECODER;
v4l2_err(v4l2_dev, "decoding not supported.\n");
return -EINVAL;

Is there any technical reason or the code has not been written ?

Thanks a lot,
Best regards,
Ga?tan Carlier.
