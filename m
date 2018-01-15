From: aryabinin@virtuozzo.com (Andrey Ryabinin)
Date: Mon, 15 Jan 2018 19:35:11 +0300
Subject: [PATCH v2 2/2] kasan: clean up KASAN_SHADOW_SCALE_SHIFT usage
In-Reply-To: <34937ca3b90736eaad91b568edf5684091f662e3.1515775666.git.andreyknvl@google.com>
References: <cover.1515775666.git.andreyknvl@google.com>
 <34937ca3b90736eaad91b568edf5684091f662e3.1515775666.git.andreyknvl@google.com>
Message-ID: <b3d59ebe-9bdd-46a2-377d-8f242ccef426@virtuozzo.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 01/12/2018 07:49 PM, Andrey Konovalov wrote:
> Right now the fact that KASAN uses a single shadow byte for 8 bytes of
> memory is scattered all over the code.
> 
> This change defines KASAN_SHADOW_SCALE_SHIFT early in asm include files
> and makes use of this constant where necessary.
> 
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> ---

Acked-by: Andrey Ryabinin <aryabinin@virtuozzo.com>
