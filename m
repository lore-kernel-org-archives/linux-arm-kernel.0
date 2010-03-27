From: linus.ml.walleij@gmail.com (Linus Walleij)
Date: Sat, 27 Mar 2010 21:57:04 +0100
Subject: [PATCH] Including device.h and resource.h header files in
	linux/amba/bus.h
In-Reply-To: <22dbbef21003270455i1e7175cbxbbd2e2112931c192@mail.gmail.com>
References: <1269511413-30621-1-git-send-email-viresh.kumar@st.com>
	<63386a3d1003261031p63224296pd4b1a649108af00b@mail.gmail.com>
	<22dbbef21003262207i3fa10157jf3b8577b307ce99d@mail.gmail.com>
	<63386a3d1003270213t6939202dof4265d9c8372407a@mail.gmail.com>
	<22dbbef21003270455i1e7175cbxbbd2e2112931c192@mail.gmail.com>
Message-ID: <63386a3d1003271357i7cb5aa84w35a447ed34db8d72@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[Viresh]
> On Sat, Mar 27, 2010 at 2:43 PM, Linus Walleij
>> On the other hand Documentation/SubmitChecklist contains this:
>>
>> 1: If you use a facility then #include the file that defines/declares
>> ? that facility. ?Don't depend on other header files pulling in ones
>> ? that you use.
>
> I agree on the above statement.
>
>(...)
> Again, according to above statement from submitchecklist:
> shouldn't bus.h include device.h and resource.h, as it is using
> these facilities.

Yes I think you're right, looks like it should be applied then!
Acked-by:

Yours,
Linus Walleij
