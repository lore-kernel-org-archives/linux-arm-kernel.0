From: friesendrywall@gmail.com (Erik Friesen)
Date: Wed, 3 Feb 2016 10:11:39 -0500
Subject: SGTL5000 misc
In-Reply-To: <CAOMZO5C4QUHnJr=pisnYWCYZ0zUt+7HO846aPQui0zcLyX0N-Q@mail.gmail.com>
References: <CAEuupiuhPR48Upo=8f0zV8cxf0Vefgx3qA+vC+QDWAOV4n-e3Q@mail.gmail.com>
 <CAOMZO5BPNc1ncz6J8yhcBYywCVuTxKYMYhiNUt_Jq3LZsKdi+A@mail.gmail.com>
 <CAEuupiszxAj7JkJu-5ozqgEnTWkz9FQEpxN8dmEN+KtaV-76ww@mail.gmail.com>
 <CAOMZO5DhrzdVyTVPB3FNquV4rDQ8a0MQrsJMosVsUQN63hj1Ww@mail.gmail.com>
 <CAEuupiuoB7nMSc8Fbyort1rJd=ZhYc0zfJNkd=ckUYk1qd8Z7Q@mail.gmail.com>
 <CAOMZO5C4QUHnJr=pisnYWCYZ0zUt+7HO846aPQui0zcLyX0N-Q@mail.gmail.com>
Message-ID: <CAEuupivdftoopCOX3f7KRbV9poKdjdD3s9hfcbgB2TYjHmrjvw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There is no difference in code that I can tell between the two.  I am
not asking to have this fixed, rather just some ideas on how I can
implement this. If alsa-devel list is the preferred asking place, I'll
go there.

The riotboard used kernel 4.3.0-rc2-00019-gbcee19f with the same results.

On Wed, Feb 3, 2016 at 9:51 AM, Fabio Estevam <festevam@gmail.com> wrote:
> On Wed, Feb 3, 2016 at 12:46 PM, Erik Friesen <friesendrywall@gmail.com> wrote:
>> It appears sgtl5000.c is patched the same in my kernel as the commit mentioned.
>>
>> The problem the way I see it, is that there is no mechanism to deal
>> with a reboot on the codec itself.
>
> There is no reset line nor reset command on the sgtl5000.
>
>> This alsa stuff has too many layers.  At least coming from a non os
>> embedded angle it seems that way.
>
> I would suggest you to try 4.4.1 and if you still see an issue with
> the codec, then report it back to the alsa-devel at alsa-project.org
> list.
