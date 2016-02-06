From: friesendrywall@gmail.com (Erik Friesen)
Date: Sat, 6 Feb 2016 12:22:35 -0500
Subject: SGTL5000 misc
In-Reply-To: <CAOMZO5Dos2xidZWrGffHRw33GjcJi+CvitFC5hKW3Hy0++GEmg@mail.gmail.com>
References: <CAEuupiuhPR48Upo=8f0zV8cxf0Vefgx3qA+vC+QDWAOV4n-e3Q@mail.gmail.com>
 <CAOMZO5BPNc1ncz6J8yhcBYywCVuTxKYMYhiNUt_Jq3LZsKdi+A@mail.gmail.com>
 <CAEuupiszxAj7JkJu-5ozqgEnTWkz9FQEpxN8dmEN+KtaV-76ww@mail.gmail.com>
 <CAOMZO5DhrzdVyTVPB3FNquV4rDQ8a0MQrsJMosVsUQN63hj1Ww@mail.gmail.com>
 <CAEuupiuoB7nMSc8Fbyort1rJd=ZhYc0zfJNkd=ckUYk1qd8Z7Q@mail.gmail.com>
 <CAOMZO5C4QUHnJr=pisnYWCYZ0zUt+7HO846aPQui0zcLyX0N-Q@mail.gmail.com>
 <CAEuupivdftoopCOX3f7KRbV9poKdjdD3s9hfcbgB2TYjHmrjvw@mail.gmail.com>
 <CAEuupit8pVdnehkZkZPmq1QBHaS0sUG4NFuVFX37dKHn18j7DQ@mail.gmail.com>
 <CAOMZO5BxFRzi3qJAK=xDGger_MK9GZhuM00ugo836PHK_zJKjQ@mail.gmail.com>
 <CAEuupium67HD-sz+ViPx8-L4S0TsS-C8ZrX3po382r=E-9QYgw@mail.gmail.com>
 <CAOMZO5Dos2xidZWrGffHRw33GjcJi+CvitFC5hKW3Hy0++GEmg@mail.gmail.com>
Message-ID: <CAEuupiti=Z9CeQpgUyvyQcfWEE_ReS4RpY9sHtY=OdN3YFjZQw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Well, I have posted a thing or two there, not sure if the mailing list
is even working, as I haven't received any replies.

On Fri, Feb 5, 2016 at 5:00 AM, Fabio Estevam <festevam@gmail.com> wrote:
> On Fri, Feb 5, 2016 at 1:08 AM, Erik Friesen <friesendrywall@gmail.com> wrote:
>> There is another issue here, but when I have this connected to
>> external power, it won't start the card on every other boot.
>>
>> With the code below, it seems to start every time.  If I don't skip,
>> it dies on #8, which is the write of 0x7060 to CHIP_ANA_POWER
>>
>> This embeddedarm board supposedly power cycles the regulators, don't
>> know if that is a factor or not.  The board finishes powerup 0x4060,
>> but comes back on reboot at the reset value of 0x7060
>
> It would be nice if you could send a patch to alsa-devel mailing list,
> so that this can be properly reviewed there.
