From: jsgood.yang@samsung.com (Jinsung Yang)
Date: Mon, 07 Sep 2009 19:07:29 +0900
Subject: [PATCH 09/12] [ARM][S3C6410] Add definitions of keypad register
In-Reply-To: <9c9fda240909061656i17a63cb6m95462bea6f33ae0c@mail.gmail.com>
References: <00a701ca2e2d$0031cc30$00956490$%yang@samsung.com>
	<9c9fda240909061656i17a63cb6m95462bea6f33ae0c@mail.gmail.com>
Message-ID: <002201ca2fa3$02487c40$06d974c0$%yang@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

> Can you re-organize it as each register. I mean KEYIFCON fileds first,
> KEYIFSTRCLR files second and so on.
> 
> Can't figure out well
> 

I'm not sure what you tell me about..
Do you mean something like that?

#define REG1
#define REG1_FIELD1
#define REG1_FIELD2

#define REG2
#define REG2_FIELD1
#define REG2_FIELD2

#define REG3
#define REG3_FIELD1
#define REG3_FIELD2

Or like this?
#define REG1
#define REG2
#define REG3

#define REG1_FIELD1
#define REG1_FIELD2
#define REG2_FIELD1
#define REG2_FIELD2
#define REG3_FIELD1
#define REG3_FIELD2
