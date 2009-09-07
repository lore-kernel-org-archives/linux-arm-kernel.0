From: kmpark@infradead.org (Kyungmin Park)
Date: Mon, 7 Sep 2009 19:09:55 +0900
Subject: [PATCH 09/12] [ARM][S3C6410] Add definitions of keypad register
In-Reply-To: <002201ca2fa3$02487c40$06d974c0$%yang@samsung.com>
References: <00a701ca2e2d$0031cc30$00956490$%yang@samsung.com>
	<9c9fda240909061656i17a63cb6m95462bea6f33ae0c@mail.gmail.com>
	<002201ca2fa3$02487c40$06d974c0$%yang@samsung.com>
Message-ID: <9c9fda240909070309i3dbf4820jb5b53cfeabc478c2@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 7, 2009 at 7:07 PM, Jinsung Yang<jsgood.yang@samsung.com> wrote:
> Hi,
>
>> Can you re-organize it as each register. I mean KEYIFCON fileds first,
>> KEYIFSTRCLR files second and so on.
>>
>> Can't figure out well
>>
>
> I'm not sure what you tell me about..
> Do you mean something like that?
>
> #define REG1
> #define REG1_FIELD1
> #define REG1_FIELD2
>
> #define REG2
> #define REG2_FIELD1
> #define REG2_FIELD2
>
> #define REG3
> #define REG3_FIELD1
> #define REG3_FIELD2
>
> Or like this?
> #define REG1
> #define REG2
> #define REG3
>
> #define REG1_FIELD1
> #define REG1_FIELD2
> #define REG2_FIELD1
> #define REG2_FIELD2
> #define REG3_FIELD1
> #define REG3_FIELD2
>

latter

 #define REG1_OFFSET
 #define REG2_OFFSET
 #define REG3_OFFSET

/* REG1 field */
#define REG1_FIELD1
#define REG1_FIELD2

/* REG2 field */
#define REG2_FIELD1
#define REG2_FIELD2

/* REG3 field */
#define REG3_FIELD1
#define REG3_FIELD2

How about to review the another keypad drivers?

Thank you,
Kyungmin Park
