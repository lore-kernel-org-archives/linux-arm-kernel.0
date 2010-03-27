From: linus.ml.walleij@gmail.com (Linus Walleij)
Date: Sat, 27 Mar 2010 10:13:16 +0100
Subject: [PATCH] Including device.h and resource.h header files in
	linux/amba/bus.h
In-Reply-To: <22dbbef21003262207i3fa10157jf3b8577b307ce99d@mail.gmail.com>
References: <1269511413-30621-1-git-send-email-viresh.kumar@st.com>
	<63386a3d1003261031p63224296pd4b1a649108af00b@mail.gmail.com>
	<22dbbef21003262207i3fa10157jf3b8577b307ce99d@mail.gmail.com>
Message-ID: <63386a3d1003270213t6939202dof4265d9c8372407a@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2010/3/27 viresh kumar <viresh.linux@gmail.com>:

> Some time back i have initiated a thread regarding this type of issues. You can
> find them here:
>
> http://lists.infradead.org/pipermail/linux-arm-kernel/2010-February/010258.html
>
> And my understanding after the discussion was:
>
> It is the responsibility of a header files, using types definitions
> from outside world,
> to include all header files required for proper compilation.
> This is not the responsibility of the user using this file to add
> dependency header in
> his source files.

On the other hand Documentation/SubmitChecklist contains this:

1: If you use a facility then #include the file that defines/declares
   that facility.  Don't depend on other header files pulling in ones
   that you use.

Then this falls back on the definition of "facility". (And other academic
discussions.)

I guess Russell will need to decide on this.

Linus
