From: tomer.ashur@esat.kuleuven.be (Tomer Ashur)
Date: Mon, 22 Oct 2018 13:20:51 +0200
Subject: [RFC PATCH v2 00/12] crypto: Adiantum support
In-Reply-To: <2395454e-a0dc-408f-4138-9d15ab5f20b8@esat.kuleuven.be>
References: <20181015175424.97147-1-ebiggers@kernel.org>
 <CAHmME9p1aiqWZ4+viaLscO8+qmixdVhMA1MAtMAFEHPG36DcPg@mail.gmail.com>
 <CA+_SqcDszvqfH7qvEyi8QW2RqkA1kpV6L7VWxhtw5Ogzeovhbg@mail.gmail.com>
 <2395454e-a0dc-408f-4138-9d15ab5f20b8@esat.kuleuven.be>
Message-ID: <ebd9d96e-4a2c-528d-b8e8-67907f2a8be0@esat.kuleuven.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> On 19-Oct-18 8:19 PM, Paul Crowley wrote:
>> I would prefer not to wait. Unlike a new primitive whose strength can
>> only be known through attempts at cryptanalysis, Adiantum is a
>> construction based on
>> well-understood and trusted primitives; it is secure if the proof
>> accompanying it is correct. Given that (outside competitions or
>> standardization efforts) no-one ever issues public statements that
>> they think algorithms or proofs are good, what I'm expecting from
>> academia is silence :) The most we could hope for would be getting the
>> paper accepted at a conference, and we're pursuing that but there's a
>> good chance that won't happen simply because it's not very novel. It
>> basically takes existing ideas and applies them using a stream cipher
>> instead of a block cipher, and a faster hashing mode; it's also a
>> small update from HPolyC. I've had some private feedback that the
>> proof seems correct, and that's all I'm expecting to get.
>
I tend to agree with Paul on this point. This is a place where academia
needs to improve. An attempt to do so is the Real World Crypto
conference (RWC; https://rwc.iacr.org/2019/), but the deadline for
submissions was October 1st. For HpolyC I asked a few people to take a
look at the construction and the consensus was that it seems secure but
that the proof style makes it hard to verify. I haven't had the time yet
to read the Adiantum paper (and I'm not a provable security person
anyway) but I suppose Paul took the comments he received on this into
account and that's the best we can hope for. Academia simply moves in a
different pace and has different incentives.

?Tomer

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20181022/152c9cb5/attachment-0001.sig>
