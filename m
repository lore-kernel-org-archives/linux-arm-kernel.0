From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Tue, 4 Nov 2014 17:00:37 +0100
Subject: [PATCH v2] mmc: atmel-mci: add runtime pm support
In-Reply-To: <20141104131459.GR20550@ldesroches-Latitude-E6320>
References: <1414641641-32691-1-git-send-email-wenyou.yang@atmel.com>
 <CAPDyKFpVjoyNWpuZJ=k=nvcZkfarJtJ9oNAVjRBvmqZKuedxfA@mail.gmail.com>
 <20141104131459.GR20550@ldesroches-Latitude-E6320>
Message-ID: <CAPDyKFqAZTT2mOUpKbM74ACtke=EPOCRDKj95X6YZikNxbTLvQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 4 November 2014 14:14, Ludovic Desroches <ludovic.desroches@atmel.com> wrote:
> On Tue, Nov 04, 2014 at 11:05:56AM +0100, Ulf Hansson wrote:
>> On 30 October 2014 05:00, Wenyou Yang <wenyou.yang@atmel.com> wrote:
>> > Add runtime pm support to atmel mci controller.
>> > Use runtime pm APIs to enable/disable atmel mci's clock.
>> > Use runtime autosuspend APIs to enable auto suspend delay.
>> >
>> > Signed-off-by: Wenyou Yang <wenyou.yang@atmel.com>
>>
> Acked-by: Ludovic Desroches <ludovic.desroches@atmel.com>
>
>> Ludovic, any objections to this one?
>
> I am not a PM runtime guru, since you have reviewed the first version,
> it is ok for me :)

Thanks! Applied for next.

Kind regards
Uffe
