From: boris.brezillon@bootlin.com (Boris Brezillon)
Date: Tue, 21 Aug 2018 15:01:21 +0200
Subject: [PATCH v2 06/29] mtd: Add support for reading MTD devices via
 the nvmem API
In-Reply-To: <6db14f9c-edd3-5e43-839c-953bb03097ff@linaro.org>
References: <20180810080526.27207-1-brgl@bgdev.pl>
 <20180810080526.27207-7-brgl@bgdev.pl>
 <20180817182720.6a6e5e8e@bbrezillon> <20180819133106.0420df5f@tock>
 <20180819184609.6dcdbb9a@bbrezillon>
 <5b8c30b8-41e1-d59e-542b-fef6c6469ff0@linaro.org>
 <20180820202038.5d3dc195@bbrezillon>
 <e0ec3194-fd3a-9b3d-fba8-f88447eb56e9@linaro.org>
 <20180821133916.3a1c51b1@eos>
 <6db14f9c-edd3-5e43-839c-953bb03097ff@linaro.org>
Message-ID: <20180821150121.4408672f@bbrezillon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 21 Aug 2018 13:00:04 +0100
Srinivas Kandagatla <srinivas.kandagatla@linaro.org> wrote:

> On 21/08/18 12:39, Alban wrote:
> > However we still have the a potential address space clash between the
> > nvmem cells and the main device binding.  
> Can you elaborate?
> 

Yes, I'd be interested in having a real example too, cause I don't see
what this address space clash is.
