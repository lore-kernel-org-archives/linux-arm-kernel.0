From: 21cnbao@gmail.com (Barry Song)
Date: Thu, 7 Jul 2011 21:22:25 +0800
Subject: [PATCH v4 0/3] ARM: CSR: Adding CSR SiRFprimaII platform
In-Reply-To: <201107071311.29643.arnd@arndb.de>
References: <1310020616-27856-1-git-send-email-bs14@csr.com>
	<201107071311.29643.arnd@arndb.de>
Message-ID: <CAGsJ_4yd8i2V1FeKcELFrdRd+UxY9WLVV-dG9XnJmkxrYs8j5A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2011/7/7 Arnd Bergmann <arnd@arndb.de>:
> On Thursday 07 July 2011, Barry Song wrote:
>> Changelogs:
>> -v4:
>> v3 got "Reviewed-by: Arnd Bergmann <arnd@arndb.de>"
>> stopping the 0xffffffff madness for IO_SPACE_LIMIT
>> fix .map_io compiling issue in the 1st patch
>> fix set_next_event in timer.c
>> rename GPU, USB, multimedia and SATA nodes in DTS
>> delete redundant 0x in DTS
>
> Note that when you get a 'Reviewed-by', 'Acked-by' or 'Tested-by'
> reply to one of your mails, you should add that in the patch
> changelog below your own 'Signed-off-by' in order to document
> it for the future. This ususally still holds true when you make
> further changes, just not when rewriting major parts of the patch.

i am sure i know reviewed-by/acked-by/tested-by should be added to the
end. what make me confused here is you are also the maintainer who
will merge these changes into arm-soc and finally make them pulled by
linus. generically,you will get the last signed-off-by too. if i list
"reviewed-by you", you might need to replace it by signed-off-by
finally.
anyway, i'm really not sure whether i am understanding right about that :-)

>
> For the Signed-off-by list, that should normally include only the
> people that have handled the specific patch, it doesn't imply
> authorship. Having seven people listed as Signed-off-by seems a bit
> strange in this context, but there is no clear rule against it.
> I would probably use 'Acked-by' or plain 'Cc' in the changelog for
> some of the people, depending in what way they were involved.

yes. i understand signed-off-by should only be given to people who
make the essential code changes in the special patch and people who
send or merge the special patch, but not the original author of the
original source files. for the 1st patch which is the basic board
support, in the long history of coding sirfprimaii, all the listed
people have contributed codes. so i get the names of all of them
shown. anyway, it is really too long....

>
> At the least, you should have 'Signed-off-by' the person that wrote
> most of the code, followed by the person that sends the patch at
> the bottom of the list (as you did correctly).
>
> ? ? ? ?Arnd
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>
