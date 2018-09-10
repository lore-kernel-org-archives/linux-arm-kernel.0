From: srinivas.kandagatla@linaro.org (Srinivas Kandagatla)
Date: Mon, 10 Sep 2018 11:02:05 +0100
Subject: [PATCH v2 00/16] nvmem: rework of the subsystem for non-DT users
In-Reply-To: <CAMRc=MeT7UP57x+Q-a1ODRCvcGKKj_NSfkBLVQ9O5dhTC1DAYg@mail.gmail.com>
References: <20180907100750.14564-1-brgl@bgdev.pl>
 <da9556fd-0022-8e6a-12b4-cc3babbae5b0@linaro.org>
 <CAMRc=MeT7UP57x+Q-a1ODRCvcGKKj_NSfkBLVQ9O5dhTC1DAYg@mail.gmail.com>
Message-ID: <dec727cf-486f-8126-34f8-1b1099cec3a1@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 10/09/18 09:24, Bartosz Golaszewski wrote:
> The API changes change so many things, that these series would be
> incompatible. I can send the series separately but they would be
> co-dependent anyway. Does it sound good?

What am asking is to reorder the patches in a such a way that its easy 
to review.
ex: Order can be :
1> kref and update nvmem_unregister followed by the provider changes.
2> Add support to cell tables, cell lookup, notifier
3> general cleanup patches  followed by fixes

Current set seems to jump from one thing to other which makes it hard to 
follow and time consuming while review!


--srini

> 
> Bart
