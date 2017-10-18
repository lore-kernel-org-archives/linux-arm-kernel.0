From: ryabinin.a.a@gmail.com (Andrey Ryabinin)
Date: Wed, 18 Oct 2017 20:20:27 +0300
Subject: [PATCH v12 07/11] x86/kasan: add and use kasan_map_populate()
In-Reply-To: <6fd8291b-b3f5-46c1-2650-98a775e37fa0@oracle.com>
References: <20171013173214.27300-1-pasha.tatashin@oracle.com>
 <20171013173214.27300-8-pasha.tatashin@oracle.com>
 <f4540f92-2229-53f5-ee74-fe160bedc873@virtuozzo.com>
 <6fd8291b-b3f5-46c1-2650-98a775e37fa0@oracle.com>
Message-ID: <56120ddc-e03e-dbac-50c4-adb2287ec407@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/18/2017 08:14 PM, Pavel Tatashin wrote:
> Thank you Andrey, I will test this patch. Should it go on top or replace the existing patch in mm-tree? ARM and x86 should be done the same either both as follow-ups or both replace.
> 

 It's a replacement of your patch.


> Pavel
> 
> -- 
> To unsubscribe, send a message with 'unsubscribe linux-mm' in
> the body to majordomo at kvack.org.? For more info on Linux MM,
> see: http://www.linux-mm.org/ .
> Don't email: <a href=mailto:"dont@kvack.org"> email at kvack.org </a>
