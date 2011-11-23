From: javier.martin@vista-silicon.com (javier Martin)
Date: Wed, 23 Nov 2011 16:23:34 +0100
Subject: [PATCH v3 2/2] MEM2MEM: Add support for eMMa-PrP mem2mem
 operations.
In-Reply-To: <CAOMZO5AEZZEYSMXtXwCw4Qx9sY5hzZmd7t7b4teROntskBmbVQ@mail.gmail.com>
References: <1322061227-6631-1-git-send-email-javier.martin@vista-silicon.com>
 <1322061227-6631-3-git-send-email-javier.martin@vista-silicon.com>
 <CAOMZO5AEZZEYSMXtXwCw4Qx9sY5hzZmd7t7b4teROntskBmbVQ@mail.gmail.com>
Message-ID: <CACKLOr15XpqX2f0zjXRJHpj0YjQsU=STkKrTztpqkzdBKUoqtA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Fabio,

On 23 November 2011 16:19, Fabio Estevam <festevam@gmail.com> wrote:
> Javier,
>
> On Wed, Nov 23, 2011 at 1:13 PM, Javier Martin
> <javier.martin@vista-silicon.com> wrote:
>> Changes since v2:
>> - Use devres to simplify error handling.
>> - Remove unused structures.
>> - Fix clock handling.
>> - Other minor problems.
>
> It would be better if you put such comments below the --- line.
>
> For the commit message you can use the one you did for the cover
> letter (0/2) patch:

Thanks that's good advice.
I assume this is not quite an issue that requires the patch to be sent again.
Right?

-- 
Javier Martin
Vista Silicon S.L.
CDTUC - FASE C - Oficina S-345
Avda de los Castros s/n
39005- Santander. Cantabria. Spain
+34 942 25 32 60
www.vista-silicon.com
