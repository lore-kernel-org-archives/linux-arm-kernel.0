From: eric.y.miao@gmail.com (Eric Miao)
Date: Sun, 29 Nov 2009 10:25:47 +0800
Subject: [PATCH 0/3] pxa_camera: remove init() callback
In-Reply-To: <20091127213939.9bb235fa.ospite@studenti.unina.it>
References: <1258495463-26029-1-git-send-email-ospite@studenti.unina.it>
	<20091127213939.9bb235fa.ospite@studenti.unina.it>
Message-ID: <f17812d70911281825q5be6a000p24063a1bf0f17be7@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Nov 28, 2009 at 4:39 AM, Antonio Ospite
<ospite@studenti.unina.it> wrote:
> On Tue, 17 Nov 2009 23:04:20 +0100
> Antonio Ospite <ospite@studenti.unina.it> wrote:
>
>> Hi,
>>
>> this series removes the init() callback from pxa_camera_platform_data, and
>> fixes its users to do initialization statically at machine init time.
>>
> [...]
>> Antonio Ospite (3):
>> ? em-x270: don't use pxa_camera init() callback
>> ? pcm990-baseboard: don't use pxa_camera init() callback
>
> Eric, if Guennadi ACKs v2 for these two please apply them only, we are
> postponing the third one, hence you can discard it.
>

OK, fine.
