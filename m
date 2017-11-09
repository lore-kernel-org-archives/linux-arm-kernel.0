From: jonathanh@nvidia.com (Jon Hunter)
Date: Thu, 9 Nov 2017 11:29:40 +0000
Subject: next/master boot: 273 boots: 63 failed, 209 passed with 1
 untried/unknown (next-20171106)
In-Reply-To: <5f064e65-ee29-179b-8102-984d12d24d9d@collabora.com>
References: <5a0055f1.85a8500a.98d54.a4e4@mx.google.com>
 <20171106191713.d7jqg2b6zqchythw@sirena.co.uk>
 <d8e21d87-776b-beff-62af-34e5ad1febc3@nvidia.com>
 <20171107105501.7x74gdqzhr7uulp2@sirena.org.uk>
 <a384e96c-27c7-782b-75b9-7525714f5831@collabora.com>
 <613bcd63-a215-acbe-9150-c1495f7604f6@collabora.com>
 <5740b853-4898-2ebc-f67d-0808d1b44c36@nvidia.com>
 <ab2ee0a8-6584-7436-ca1b-4f1b521279b0@collabora.com>
 <7cdfa633-d9c6-881a-ae5f-f94f7e6413ee@nvidia.com>
 <5f064e65-ee29-179b-8102-984d12d24d9d@collabora.com>
Message-ID: <15792a16-6b57-a6ad-92dc-0ffaba0354db@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On 09/11/17 10:43, Guillaume Tucker wrote:

...

> I actually built these kernel revisions with module support
> disabled to speed up the builds, and no modules are being
> downloaded in the LAVA job.
> 
> If you have a public URL with your known working kernel zImage
> and dtb, let me know so I could re-run the same test LAVA boot
> test to see if I get the same results as you (i.e. no hang).

I don't have a public URL for the zImage but I can definitely email it
to you. By the way, when booting I am setting 'init=/bin/bash' so no
start-up scripts are running.

Cheers
Jon

-- 
nvpublic
