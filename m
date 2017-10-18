From: aryabinin@virtuozzo.com (Andrey Ryabinin)
Date: Wed, 18 Oct 2017 20:18:12 +0300
Subject: [PATCH v12 08/11] arm64/kasan: add and use kasan_map_populate()
In-Reply-To: <e32c677e-62ac-8977-2f9d-7fe7bda4b547@oracle.com>
References: <20171013173214.27300-1-pasha.tatashin@oracle.com>
 <20171013173214.27300-9-pasha.tatashin@oracle.com>
 <0ae84532-8dcb-10aa-9d69-79d7025b089e@virtuozzo.com>
 <ad8c5715-dc4f-1fa7-c25b-e08df68643d0@oracle.com>
 <20171018170651.GG21820@arm.com>
 <e32c677e-62ac-8977-2f9d-7fe7bda4b547@oracle.com>
Message-ID: <f1cb8d18-4d0f-1f88-c3c5-0add8c6c077a@virtuozzo.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/18/2017 08:08 PM, Pavel Tatashin wrote:
>>
>> As I said, I'm fine either way, I just didn't want to cause extra work
>> or rebasing:
>>
>> http://lists.infradead.org/pipermail/linux-arm-kernel/2017-October/535703.html
> 
> Makes sense. I am also fine either way, I can submit a new patch merging together the two if needed.
> 

Please, do this. Single patch makes more sense


> Pavel
