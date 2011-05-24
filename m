From: green@linuxhacker.ru (Oleg Drokin)
Date: Mon, 23 May 2011 20:57:10 -0400
Subject: Initial B&N Nook Color support, take four
In-Reply-To: <alpine.LNX.2.00.1105231939370.20130@banach.math.auburn.edu>
References: <1306098276-21112-1-git-send-email-green@linuxhacker.ru>
	<alpine.LNX.2.00.1105231939370.20130@banach.math.auburn.edu>
Message-ID: <4C7B1AC9-15E5-4103-B848-B5117DC7E2AD@linuxhacker.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello!

On May 23, 2011, at 8:48 PM, Theodore Kilgore wrote:

> Thank you very much for this work. I am considering the idea of buying one 
> of these Nook Color things; at least it would get good company from a 
> couple of other half-finished ARM-type projects lying around. But, most 
> particularly, I would be interested to know exactly what is meant by 
> 
> "USB peripheral mode is fully operational"
> 
> because one of the things I would wish to be able to do with the Nook is 
> to hook up a keyboard or, alternatively, a USB VGA adapter. Thus, do you 
> mean exactly that the Nook is supported as a client when hooked by USB to 
> another computer? Or does this mean that there actually is hope of having 
> it act as a USB host?

It's usb client (peripheral). The host mode is not functional and while
there is a slim chance it might work, that's not going to be pretty in the end.

If you need USB host, B&N is poised to announce new model tomorrow that will
have faster CPU and usb host support.

Bye,
    Oleg
