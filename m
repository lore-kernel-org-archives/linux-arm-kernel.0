From: rob@landley.net (Rob Landley)
Date: Tue, 2 Aug 2016 16:53:11 -0500
Subject: Please don't replace numeric parameter like 0444 with macro
In-Reply-To: <CA+55aFw5v23T-zvDZp-MmD_EYxF8WbafwwB59934FV7g21uMGQ@mail.gmail.com>
References: <CA+55aFw5v23T-zvDZp-MmD_EYxF8WbafwwB59934FV7g21uMGQ@mail.gmail.com>
Message-ID: <8f441710-caa7-b746-0556-bde89dea52f2@landley.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/02/2016 03:58 PM, Linus Torvalds wrote:
> [ So I answered similarly to another patch, but I'll just re-iterate
> and change the subject line so that it stands out a bit from the
> millions of actual patches ]
> 
> On Tue, Aug 2, 2016 at 1:42 PM, Pavel Machek <pavel@ucw.cz> wrote:
>>
>> Everyone knows what 0644 is, but noone can read S_IRUSR | S_IWUSR |
>> S_IRCRP | S_IROTH (*). Please don't do this.
> 
> Absolutely. It's *much* easier to parse and understand the octal
> numbers, while the symbolic macro names are just random line noise and
> hard as hell to understand. You really have to think about it.

Posix even specifies the numeric value for each macro in the chmod
command's extended description:

  http://pubs.opengroup.org/onlinepubs/9699919799/utilities/chmod.html

Rob
