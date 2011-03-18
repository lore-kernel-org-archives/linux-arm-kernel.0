From: vincent.palatin_lkml@m4x.org (Vincent Palatin)
Date: Fri, 18 Mar 2011 07:03:06 -0400
Subject: compiling 2.6.37 kernel in THUMB2 mode
In-Reply-To: <AANLkTimjit3ZqwjDDrpw+iBfaq34QAQr0JCDnQuBybGZ@mail.gmail.com>
References: <AANLkTi=bJwvTMk0B9N5AAbkNXEh_Wmvu75qrdHeL2Rrh@mail.gmail.com>
	<alpine.LFD.2.00.1102152257500.14920@xanadu.home>
	<AANLkTinQzK=s_r+_uaNRkq4MTPcF4zVE2aHPx5cqwYAN@mail.gmail.com>
	<AANLkTi=PLJBZ=Q-4k8ZUbX4S3w7f3WfUd9acb7iVYGBP@mail.gmail.com>
	<AANLkTi=_=jzs+MrvGbwF3L0c_eSq4nnbqE-xZ_+Z5fgH@mail.gmail.com>
	<AANLkTinKhCG4HauFHrPd=qr9vmVheH59vu2Be=tWoJft@mail.gmail.com>
	<AANLkTik1FY=K1Wuo=vnh5xuq6aS1x2d2Km=ByrCSufJC@mail.gmail.com>
	<AANLkTi=3s6ZRkaBG4uaS=7kaLWD-q2MgN0cN1otBrcmy@mail.gmail.com>
	<AANLkTikG=euGb1f4v50p9xwYtSuZ78aRgJ6XTfxy0TPR@mail.gmail.com>
	<AANLkTintEi=JO222wQARaacpfHPor5usnz-qhNAAFXjm@mail.gmail.com>
	<AANLkTi=RQ3-ZkDKPOByGsey-E45cVA-5Rj3zWOjLutiy@mail.gmail.com>
	<AANLkTik7i9Q9ctdMYno3VcJvcAHpN8g_3KifV+aen9-n@mail.gmail.com>
	<AANLkTim+f5PyGshq5jppzyk=W9t4R8Yw6jxU6VstvH55@mail.gmail.com>
	<AANLkTimjit3ZqwjDDrpw+iBfaq34QAQr0JCDnQuBybGZ@mail.gmail.com>
Message-ID: <AANLkTinywQZtCpUppZ-2eSqV6s+b+5kDZ6hRVJ36ewgi@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>> > Just one more question: whats Russell's tree?
>>
>> AFAIK: That one :
>> http://ftp.arm.linux.org.uk/pub/armlinux/kernel/git-cur/linux-2.6-arm.git
>>
>
> this does not seem to be a pointer to a valid git repo, or am I missing
> something?

The URL is unusual but
git clone http://ftp.arm.linux.org.uk/pub/armlinux/kernel/git-cur/linux-2.6-arm.git
works for me.

by the way this server connectivity has limited bandwidth, you would
rather clone the linus Tree and add this one as another remote :

git remote add arm
http://ftp.arm.linux.org.uk/pub/armlinux/kernel/git-cur/linux-2.6-arm.git
git remote update
git checkout -b arm-devel arm/devel

-- 
Vincent
