From: rusty@rustcorp.com.au (Rusty Russell)
Date: Tue, 26 Jul 2011 11:34:00 +0930
Subject: [Lguest] Current state of the lguest arm patch
In-Reply-To: <CAEx4DoFYP1JWx+c56T6s0N1soiEqU+Hnw+Fd0Kr8igOREbC5zA@mail.gmail.com>
References: <CAEx4DoFYP1JWx+c56T6s0N1soiEqU+Hnw+Fd0Kr8igOREbC5zA@mail.gmail.com>
Message-ID: <87d3gxyezz.fsf@rustcorp.com.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 25 Jul 2011 11:18:39 +0100, Nuno Felicio <nuno.felicio@gmail.com> wrote:
> Hello, first i would like to say thanks for the fantastic lguest hypervisor
> :)
> 
> Im testing the lguest arm patch, after some issues using the patched kernel
> tree given by the board builder , i have found that using some commands
> inside  the guest crashes the host.
> 
> running reboot -f, crashes the board.
> 
> 
> and
> 
> running a dummy test like this
> 
> while [ 1 ]; do dd if=/bin/busybox of=/teste.bin; sleep 1 ; done
> 1910+1 records in
> 1910+1 records out
> 978416 bytes (955.5KB) copied, Illegal instruction
> 
> 
> 
> What is the current state of the arm patch? Im asking because i not sure if
> the issue is the current state of the arm patch, or my clumsy merge
> work :)

I don't know... I've never actually run it myself.  I was really hoping
that someone who knows the ARM kernel would assist in preparing the
patch for inclusion...

Volunteers welcome :)

Thanks,
Rusty.
