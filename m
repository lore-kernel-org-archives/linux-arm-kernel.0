From: apenwarr@gmail.com (Avery Pennarun)
Date: Wed, 11 Aug 2010 12:39:53 -0400
Subject: Query: Patches break with Microsoft exchange server.
In-Reply-To: <1281544234.5107.25.camel@localhost>
References: <4C5F9B25.8080401@st.com>
	<AANLkTinxwRFLUibJECm0c3_oL5mYRkmscsw-xXgAHSTe@mail.gmail.com>
	<4C624AE1.30504@st.com> <4C62C5BD.3020808@mnsu.edu>
	<1281542305.5107.11.camel@localhost>
	<AANLkTi=9xVdfXJXpkNPUMahc7AsbxjVbZFSxeBrzvbmS@mail.gmail.com>
	<1281544234.5107.25.camel@localhost>
Message-ID: <AANLkTi=6hXj_a1X-HwYWvWt4_pBto_OQgkWE3VsDmEsJ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 11, 2010 at 12:30 PM, David Woodhouse <dwmw2@infradead.org> wrote:
> On Wed, 2010-08-11 at 12:18 -0400, Avery Pennarun wrote:
>> Out of curiosity, why fall back to one chunk at a time? ?It seems to
>> me that IMAP should be able to still support multiple outstanding
>> requests in that case, but you'd just get errors on the latter chunks.
>>
>> It is just that there was no point optimizing the workaround case?
>
> There wasn't a lot of point in optimising it.

Say no more :)

I code on some IMAP clients occasionally and I just wanted to make
sure I wasn't missing something important.

Thanks!

Avery
